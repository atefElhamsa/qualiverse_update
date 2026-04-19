import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/all_core_imports/all_core_imports.dart';

class DialogActions extends StatelessWidget {
  const DialogActions({
    super.key,
    required this.isLoading,
    required this.onCancel,
    required this.onSave,
  });

  final bool isLoading;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: onCancel,
          child: Text(
            'cancel'.tr(),
            style: TextStyle(color: AppColors.grey, fontSize: 15.sp),
          ),
        ),
        SizedBox(width: 8.w),
        CustomButton(
          buttonModel: ButtonModel(
            onPressed: isLoading ? null : onSave,
            backgroundColor: AppColors.blue,
            radius: 10,
            customText: CustomText(
              title: isLoading ? 'Saving...' : 'Save',
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 15.sp,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
