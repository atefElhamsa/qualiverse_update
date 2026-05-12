import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class LinearProgressWidget extends StatefulWidget {
  const LinearProgressWidget({super.key, required this.value});

  final double value;

  @override
  State<LinearProgressWidget> createState() => _LinearProgressWidgetState();
}

class _LinearProgressWidgetState extends State<LinearProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        LinearProgressIndicator(
          color: AppColors.grey,
          minHeight: 10,
          value: widget.value,
          backgroundColor: AppColors.grey,
          borderRadius: BorderRadius.circular(7.5.r),
          stopIndicatorColor: AppColors.green,
          valueColor: const AlwaysStoppedAnimation(Colors.green),
        ),
        if (widget.value == 1.0) ...[
          const SizedBox(height: 10),
          CustomText(
            title: "doneSuccessfully".tr(),
            textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 20.sp,
              color: AppColors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
  }
}
