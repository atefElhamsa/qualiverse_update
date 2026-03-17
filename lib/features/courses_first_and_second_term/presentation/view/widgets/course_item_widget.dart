import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../routing/all_routes_imports.dart';

class CourseItemWidget extends StatelessWidget {
  final String title;
  final CourseSuccess state;

  const CourseItemWidget({super.key, required this.title, required this.state});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final selectedModel = state.courses.firstWhere((d) => d.name == title);
        CourseCubit.get(context).selectCourse(course: selectedModel);
        context.pushNamed(
          AppRoutes.editFilesScreen,
          extra: CourseFolderArgs(courseModel: selectedModel),
        );
      },
      child: SizedBox(
        width: 218.w,
        height: 180.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          spacing: 5,
          children: [
            Container(
              height: 97.h,
              width: 218.w,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 218.w,
                child: SingleChildScrollView(
                  child: CustomText(
                    title: title,
                    textAlign: TextAlign.center,
                    textStyle: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(fontSize: 24.sp),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
