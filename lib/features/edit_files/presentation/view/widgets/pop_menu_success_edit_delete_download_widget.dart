import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../routing/all_routes_imports.dart';

class PopMenuSuccessEditDeleteDownloadWidget extends StatelessWidget {
  const PopMenuSuccessEditDeleteDownloadWidget({
    super.key,
    required this.onTap,
    required this.updateFolderCubit,
    required this.deleteFolderCubit,
  });

  final VoidCallback onTap;
  final UpdateFolderCubit updateFolderCubit;
  final DeleteFolderCubit deleteFolderCubit;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, size: 20.sp, color: AppColors.mainBlack),
      color: AppColors.colorButtonLight,
      onOpened: onTap,
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      onSelected: (value) {
        switch (value) {
          case 'delete':
            final folderId = CourseFolderCubit.get(
              context,
            ).selectedCourseFolder!.id;
            showDialog(
              context: context,
              builder: (dialogContext) => BlocProvider.value(
                value: deleteFolderCubit,
                child: BlocListener<DeleteFolderCubit, DeleteFolderState>(
                  listener: (listenerContext, state) {
                    if (state is DeleteFolderFailure) {
                      showSnackBar(
                        listenerContext,
                        state.errorMessage,
                        AppColors.red,
                      );
                    }
                    if (state is DeleteFolderSuccess) {
                      showSnackBar(
                        listenerContext,
                        state.message,
                        AppColors.green,
                      );
                      Navigator.of(dialogContext).pop();
                      CourseFolderCubit.get(context).fetchCourseFolders(
                        courseId: CourseFolderCubit.get(
                          context,
                        ).currentCourseId!,
                      );
                    }
                  },
                  child: Dialog(
                    backgroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        width: 440.w,
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.all(16.r),
                              decoration: BoxDecoration(
                                color: AppColors.red.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.delete_outline_rounded,
                                size: 40.sp,
                                color: AppColors.red,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            CustomText(
                              title: 'deleteFolder'.tr(),
                              textAlign: TextAlign.center,
                              textStyle: GoogleFonts.inter(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.red,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            CustomText(
                              title: "deleteFolderMessage".tr(),
                              textAlign: TextAlign.center,
                              textStyle: GoogleFonts.inter(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.mainBlack,
                              ),
                            ),
                            SizedBox(height: 28.h),
                            DeleteAndCancelButtons(
                              onPressed: () {
                                deleteFolderCubit.deleteFolder(folderId: folderId);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
            break;
          case 'edit':
            final folder = CourseFolderCubit.get(context).selectedCourseFolder!;

            final folderId = folder.id;
            showDialog(
              context: context,
              builder: (dialogContext) => BlocProvider.value(
                value: updateFolderCubit,
                child: BlocListener<UpdateFolderCubit, UpdateFolderState>(
                  listener: (listenerContext, state) {
                    if (state is UpdateFolderSuccess) {
                      showSnackBar(
                        listenerContext,
                        state.message,
                        AppColors.green,
                      );
                      Navigator.of(dialogContext).pop();
                      CourseFolderCubit.get(context).fetchCourseFolders(
                        courseId: CourseFolderCubit.get(
                          context,
                        ).currentCourseId!,
                      );
                    }
                    if (state is UpdateFolderFailure) {
                      showSnackBar(
                        listenerContext,
                        state.errorMessage,
                        AppColors.red,
                      );
                    }
                  },
                  child: Dialog(
                    backgroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        width: 440.w,
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.all(16.r),
                              decoration: BoxDecoration(
                                color: AppColors.drColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.drive_file_rename_outline_rounded,
                                size: 40.sp,
                                color: AppColors.drColor,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            CustomText(
                              title: 'updateFolder'.tr(),
                              textAlign: TextAlign.center,
                              textStyle: GoogleFonts.inter(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.drColor,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            CustomText(
                              title: context.locale.languageCode == 'ar'
                                  ? 'قم بتحديث اسم المجلد باللغتين العربية والإنجليزية'
                                  : 'Update the folder name in Arabic and English',
                              textAlign: TextAlign.center,
                              textStyle: GoogleFonts.inter(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.greyLight,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            UpdateFolderField(
                              updateFolderCubit: updateFolderCubit,
                            ),
                            SizedBox(height: 28.h),
                            UpdateAndCancelButtons(
                              updateFolderCubit: updateFolderCubit,
                              folderId: folderId,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
            break;
        }
      },
      itemBuilder: (context) => [
        buildMenuItem(
          value: 'delete',
          icon: Icons.delete_outline,
          text: 'delete',
        ),
        buildMenuItem(value: 'edit', icon: Icons.edit, text: 'edit'),
      ],
    );
  }
}
