import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class EditFilesList extends StatelessWidget {
  const EditFilesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseFolderCubit, CourseFolderState>(
      builder: (context, state) {
        if (state is CourseFolderLoading) {
          return const EditFilesShimmer();
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
              title: context.locale.languageCode == 'ar'
                  ? 'لا توجد مجلدات مضافة حالياً. يمكنك إضافة مجلد جديد باستخدام الزر أعلاه.'
                  : 'No folders added yet. You can add a new folder using the button above.',
              onPressed: () {
                CourseFolderCubit.get(context).fetchCourseFolders(
                  courseId: CourseFolderCubit.get(context).currentCourseId!,
                );
              },
            );
          } else {
            return ContainerWidget(
              widget: LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = (constraints.maxWidth - 10.w) / 2;
                  return Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: List.generate(
                      courseFolders.length,
                      (index) => SizedBox(
                        width: itemWidth,
                        child: GestureDetector(
                          onTap: () {
                            CourseFolderCubit.get(context).selectCourseFolder(
                              courseFolder: courseFolders[index],
                            );
                            showDialog(
                              context: context,
                              builder: (_) => BlocProvider(
                                create: (_) => FolderFilesCubit()
                                  ..getFolderFiles(
                                    folderId: courseFolders[index].id,
                                  ),
                                child: Dialog(
                                  insetPadding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 30.h,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30.r),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.85,
                                      child: FolderFilesScreen(
                                        folderName: courseFolders[index].name,
                                        folderId: courseFolders[index].id,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: ItemTextWidgetForContainer(
                            courseFolderModel: courseFolders[index],
                          ),
                        ),
                      ),
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
