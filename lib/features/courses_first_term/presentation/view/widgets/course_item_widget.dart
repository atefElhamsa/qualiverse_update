import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class CourseItemWidget extends StatelessWidget {
  final String title;

  const CourseItemWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 218.w,
        height: 180.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          spacing: 5,
          children: [
            Container(
              height: 97.h,
              width: 218.w,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 218.w,
                child: CustomText(
                  title: title.tr(),
                  textAlign: TextAlign.center,
                  textStyle: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(fontSize: 24.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
