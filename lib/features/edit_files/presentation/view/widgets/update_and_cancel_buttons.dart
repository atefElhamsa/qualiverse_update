import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
                  backgroundColor: AppColors.green,
                  radius: 20,
                  space: 10.h,
                  customText: CustomText(
                    title: "update".tr(),
                    textStyle: Theme.of(context).textTheme.headlineLarge!
                        .copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              CustomButton(
                buttonModel: ButtonModel(
                  onPressed: () {
                    context.pop();
                  },
                  backgroundColor: AppColors.red,
                  radius: 20,
                  space: 10.h,
                  customText: CustomText(
                    title: "cancel".tr(),
                    textStyle: Theme.of(context).textTheme.headlineLarge!
                        .copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                  ),
                ),
              ),
            ],
          );
  }
}
