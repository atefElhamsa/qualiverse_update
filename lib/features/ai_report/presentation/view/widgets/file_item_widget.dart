import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class FileItemWidget extends StatelessWidget {
  const FileItemWidget({super.key, required this.fileItemModel});

  // file item model
  final FileItemModel fileItemModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        // check if file is null
        onTap: fileItemModel.file == null ? fileItemModel.onTap : null,
        child: SizedBox(
          width: 380.w,
          // choose between file not found and file found
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 201.h,
                width: 380.w,
                child: DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    radius: Radius.circular(40.r),
                    strokeWidth: 2,
                    color: AppColors.greyLight,
                    dashPattern: const [6, 6],
                  ),
                  child: Center(
                    child: fileItemModel.file == null
                        ? AiReportNotFoundFile(
                            titleFile: fileItemModel.titleFile,
                          )
                        : AiReportFoundFile(file: fileItemModel.file),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomText(
                title: fileItemModel.aboutFile!,
                textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 24.sp,
                  color: AppColors.greyLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
