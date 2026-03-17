import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
                  backgroundColor: AppColors.green,
                  radius: 20,
                  space: 10.h,
                  customText: CustomText(
                    title: "create".tr(),
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
