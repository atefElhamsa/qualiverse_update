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
          return Dialog(
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
                        Icons.create_new_folder_outlined,
                        size: 40.sp,
                        color: AppColors.drColor,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    CustomText(
                      title: 'createFolder'.tr(),
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
                          ? 'أدخل اسم المجلد باللغتين العربية والإنجليزية لتنظيم ملفاتك'
                          : 'Enter folder names in Arabic and English to organize files',
                      textAlign: TextAlign.center,
                      textStyle: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyLight,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    CreateFolderField(createFolderCubit: createFolderCubit),
                    SizedBox(height: 28.h),
                    CreateAndCancelButtons(
                      createFolderCubit: createFolderCubit,
                      courseId: courseId!,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
