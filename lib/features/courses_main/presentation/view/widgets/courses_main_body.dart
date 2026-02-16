import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

// Define a stateful widget for the main body of the courses screen.
class CoursesMainBody extends StatelessWidget {
  const CoursesMainBody({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = HomeBodyInherited.of(context);
    final isDrawerVisible = inherited.isDrawerVisible;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DepartmentCubit()..fetchDepartments(),
        ),
        BlocProvider(
          create: (context) => AcademicYearCubit()..fetchAcademicYears(),
        ),
        BlocProvider(create: (context) => LevelCubit()..fetchLevels()),
      ],
      child: CustomScaffold(
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            !isDrawerVisible
                ? CustomScaffoldTop(controller: inherited.controller)
                : const SizedBox(),
            Center(
              child: CustomText(
                title: "coursesFile".tr(),
                textStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 50.sp,
                ), // Apply custom text style.
              ),
            ),
            const CoursesMainDetails(),
          ],
        ),
      ),
    );
  }
}
