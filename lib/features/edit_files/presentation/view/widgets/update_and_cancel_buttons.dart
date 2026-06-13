import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../routing/all_routes_imports.dart';

class UpdateAndCancelButtons extends StatelessWidget {
  const UpdateAndCancelButtons({
    super.key,
    required this.updateFolderCubit,
    required this.folderId,
  });

  final UpdateFolderCubit updateFolderCubit;
  final int folderId;

  @override
  Widget build(BuildContext context) {
    return updateFolderCubit.state is UpdateFolderLoading
        ? const CustomLoading()
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton(
                buttonModel: ButtonModel(
                  onPressed: () {
                    updateFolderCubit.updateFolder(folderId: folderId);
                  },
                  backgroundColor: AppColors.drColor,
                  radius: 12,
                  space: 12.h,
                  customText: CustomText(
                    title: "update".tr(),
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
