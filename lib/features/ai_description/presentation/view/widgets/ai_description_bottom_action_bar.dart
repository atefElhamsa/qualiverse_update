import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiDescriptionBottomActionBar extends StatelessWidget {
  final int courseId;
  final AiDescriptionCubit cubit;

  const AiDescriptionBottomActionBar({
    super.key,
    required this.courseId,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: StartEndNumberFileCompleted(
                    countUploadedFileDone: cubit.countUploadedFileDone,
                    maxFiles: 2,
                    courseId: courseId,
                  ),
                ),
                SizedBox(width: 20.w),
                EditApprovedButtons(
                  onApprovedPressed: () => cubit.uploadAiFiles(),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            LinearProgressWidget(value: cubit.uploadProgress),
          ],
        ),
      ),
    );
  }
}
