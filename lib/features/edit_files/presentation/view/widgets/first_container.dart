import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class FirstContainer extends StatelessWidget {
  const FirstContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseFolderCubit, CourseFolderState>(
      builder: (context, state) {
        if (state is CourseFolderLoading) {
          return const CustomLoading();
        }
        if (state is CourseFolderError) {
          return RetryWidget(
            title: state.message,
            onPressed: () {
              CourseFolderCubit.get(context).fetchCourseFolders(
                courseId: CourseFolderCubit.get(context).currentCourseId!,
              );
            },
          );
        }
        if (state is CourseFolderSuccess) {
          final courseFolders = state.courseFolders;
          if (courseFolders.isEmpty) {
            return RetryWidget(
              title: 'No Data Found',
              onPressed: () {
                CourseFolderCubit.get(context).fetchCourseFolders(
                  courseId: CourseFolderCubit.get(context).currentCourseId!,
                );
              },
            );
          } else {
            return ContainerWidget(
              widget: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: courseFolders.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  childAspectRatio: 6,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      CourseFolderCubit.get(
                        context,
                      ).selectCourseFolder(courseFolder: courseFolders[index]);
                    },
                    child: ItemTextWidgetForContainer(
                      courseFolderModel: courseFolders[index],
                    ),
                  );
                },
              ),
            );
          }
        }
        return const SizedBox();
      },
    );
  }
}
