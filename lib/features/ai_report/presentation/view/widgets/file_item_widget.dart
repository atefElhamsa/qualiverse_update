import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
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
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
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
                      radius: Radius.circular(30.r),
                      strokeWidth: 2.5,
                      color: AppColors.scaffoldLight1.withOpacity(0.3),
                      dashPattern: const [8, 5],
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: fileItemModel.file == null
                              ? AiReportNotFoundFile(
                                  titleFile: fileItemModel.titleFile,
                                )
                              : AiReportFoundFile(file: fileItemModel.file),
                        ),
                        if (fileItemModel.file != null)
                          Positioned(
                            top: 10.h,
                            right: 10.w,
                            child: Tooltip(
                              message: "changeFile".tr(),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20.r),
                                  onTap: fileItemModel.onTap,
                                  child: Container(
                                    padding: EdgeInsets.all(8.r),
                                    decoration: BoxDecoration(
                                      color: AppColors.colorTapAdminDashboard,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      color: AppColors.colorButtonLight,
                                      size: 20.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                CustomText(
                  title: fileItemModel.aboutFile ?? "",
                  textAlign: TextAlign.center,
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 24.sp,
                    color: AppColors.greyLight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
