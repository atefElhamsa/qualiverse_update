import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../routing/all_routes_imports.dart';

class CreateAndCancelButtons extends StatelessWidget {
  const CreateAndCancelButtons({
    super.key,
    required this.createFolderCubit,
    required this.courseId,
  });

  final CreateFolderCubit createFolderCubit;
  final int courseId;

  @override
  Widget build(BuildContext context) {
    return createFolderCubit.state is CreateFolderLoading
        ? const CustomLoading()
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton(
                buttonModel: ButtonModel(
                  onPressed: () {
                    createFolderCubit.createFolder(courseId: courseId);
                  },
                  backgroundColor: AppColors.drColor,
                  radius: 12,
                  space: 12.h,
                  customText: CustomText(
                    title: "create".tr(),
                    textStyle: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              CustomButton(
                buttonModel: ButtonModel(
                  onPressed: () {
                    createFolderCubit.newFolderNameArController.clear();
                    createFolderCubit.newFolderNameEnController.clear();
                    context.pop();
                  },
                  backgroundColor: const Color(0xFFE5E7EB),
                  radius: 12,
                  space: 12.h,
                  customText: CustomText(
                    title: "cancel".tr(),
                    textStyle: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mainBlack,
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
