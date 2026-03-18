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
                  child: AlertDialog(
                    backgroundColor: AppColors.white,
                    actionsPadding: EdgeInsets.all(16.h),
                    actionsAlignment: MainAxisAlignment.center,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    title: CustomText(
                      title: 'deleteFolder'.tr(),
                      textAlign: TextAlign.center,
                      textStyle: GoogleFonts.inter(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.red,
                      ),
                    ),
                    content: CustomText(
                      title: "deleteFolderMessage".tr(),
                      textStyle: Theme.of(context).textTheme.headlineLarge!,
                    ),
                    actions: [
                      DeleteAndCancelButtons(
                        deleteFolderCubit: deleteFolderCubit,
                        folderId: folderId,
                      ),
                    ],
                  ),
                ),
              ),
            );
            break;
          case 'download':
            debugPrint("Download");
            break;
          case 'edit':
            final folderId = CourseFolderCubit.get(
              context,
            ).selectedCourseFolder!.id;
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
                  child: AlertDialog(
                    backgroundColor: AppColors.white,
                    actionsPadding: EdgeInsets.all(16.h),
                    actionsAlignment: MainAxisAlignment.center,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    title: CustomText(
                      title: 'updateFolder'.tr(),
                      textAlign: TextAlign.center,
                      textStyle: GoogleFonts.inter(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.drColor,
                      ),
                    ),
                    content: UpdateFolderField(
                      updateFolderCubit: updateFolderCubit,
                    ),
                    actions: [
                      UpdateAndCancelButtons(
                        updateFolderCubit: updateFolderCubit,
                        folderId: folderId,
                      ),
                    ],
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
        buildMenuItem(
          value: 'download',
          icon: Icons.download,
          text: 'download',
        ),
        buildMenuItem(value: 'edit', icon: Icons.edit, text: 'edit'),
      ],
    );
  }
}
