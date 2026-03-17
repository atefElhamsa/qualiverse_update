import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../routing/all_routes_imports.dart';

class ShowCreateFolderDialog extends StatelessWidget {
  const ShowCreateFolderDialog({
    super.key,
    required this.courseFolderCubit,
    required this.courseId,
    required this.createFolderCubit,
  });

  final CourseFolderCubit courseFolderCubit;
  final int? courseId;
  final CreateFolderCubit createFolderCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: CreateFolderCubit.get(context),
      child: BlocConsumer<CreateFolderCubit, CreateFolderState>(
        listener: (dialogContext, state) {
          if (state is CreateFolderFailure) {
            showSnackBar(dialogContext, state.errorMessage, AppColors.red);
          }
          if (state is CreateFolderSuccess) {
            showSnackBar(dialogContext, state.message, AppColors.green);
            dialogContext.pop();
            courseFolderCubit.fetchCourseFolders(courseId: courseId!);
          }
        },
        builder: (context, state) {
          return AlertDialog(
            backgroundColor: AppColors.white,
            actionsPadding: EdgeInsets.all(16.h),
            actionsAlignment: MainAxisAlignment.center,
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            title: CustomText(
              title: 'createFolder'.tr(),
              textAlign: TextAlign.center,
              textStyle: GoogleFonts.inter(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.drColor,
              ),
            ),
            content: CreateFolderField(createFolderCubit: createFolderCubit),
            actions: [
              CreateAndCancelButtons(
                createFolderCubit: createFolderCubit,
                courseId: courseId!,
              ),
            ],
          );
        },
      ),
    );
  }
}
