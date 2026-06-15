import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class AiDescriptionBottomActionBar extends StatelessWidget {
  final int courseId;
  final AiDescriptionCubit cubit;
  final VoidCallback? onApprovedPressed;

  const AiDescriptionBottomActionBar({
    super.key,
    required this.courseId,
    required this.cubit,
    this.onApprovedPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiDescriptionCubit, AiDescriptionState>(
      builder: (context, state) {
        final isUploaded = cubit.isUploaded;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
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
                      title: isUploaded ? "approved".tr() : "uploadFile".tr(),
                      icon: isUploaded
                          ? Icons.check_circle_outline
                          : Icons.cloud_upload_outlined,
                      onApprovedPressed: () {
                        if (isUploaded) {
                          onApprovedPressed?.call();
                        } else {
                          cubit.uploadAiFiles();
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                LinearProgressWidget(value: cubit.uploadProgress),
              ],
            ),
          ),
        );
      },
    );
  }
}
