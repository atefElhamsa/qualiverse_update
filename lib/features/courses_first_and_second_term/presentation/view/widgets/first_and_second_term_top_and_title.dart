import 'package:dio/dio.dart' as dio;
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';
import 'package:qualiverse/features/courses_first_and_second_term/presentation/view/widgets/statistics_preview_dialog.dart';

class FirstTermTopAndTitle extends StatelessWidget {
  const FirstTermTopAndTitle({
    super.key,
    required this.tile,
    required this.courseArgs,
  });

  final String tile;
  final CourseArgs courseArgs;

  Future<void> _pickAndPreview(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xls', 'xlsx'],
      allowMultiple: false,
    );
    if (result == null || result.files.single.path == null) return;

    final file = await dio.MultipartFile.fromFile(
      result.files.single.path!,
      filename: result.files.single.name,
    );

    if (context.mounted) {
      EvidenceFolderFilesCubit.get(context).previewStatisticsFile(
        file: file,
        academicYearId: courseArgs.yearId,
        termId: courseArgs.termModel.id,
        levelId: courseArgs.levelId,
        departmentId: courseArgs.departmentId,
      );
    }
  }

  void _showConfirmDialog(BuildContext context, StatisticsPreviewData data) {
    final evidenceCubit = EvidenceFolderFilesCubit.get(context);

    showDialog(
      context: context,
      builder: (innerContext) => BlocProvider(
        create: (context) => CourseCubit(),
        child: StatisticsPreviewDialog(
          data: data,
          courseArgs: courseArgs,
          evidenceCubit: evidenceCubit,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EvidenceFolderFilesCubit, EvidenceFolderFilesState>(
      listener: (context, state) {
        if (state is StatisticsPreviewSuccess) {
          _showConfirmDialog(context, state.previewData);
        }
        if (state is StatisticsPreviewFailure) {
          showSnackBar(context, state.error, Colors.red);
        }
        if (state is ConfirmStatisticsSuccess) {
          showSnackBar(context, state.message, Colors.green);
        }
        if (state is ConfirmStatisticsFailure) {
          showSnackBar(context, state.error, Colors.red);
        }
      },
      builder: (context, state) {
        final isLoading =
            state is StatisticsPreviewLoading ||
            state is ConfirmStatisticsLoading;
        return SizedBox(
          width: double.infinity,
          height: 260.h,
          child: Stack(
            children: [
              const FirstTermTop(),
              PositionedDirectional(
                top: 55.h,
                end: 30.w,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.progressColor.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: 250.w,
                    height: 50.h,
                    child: CustomButton(
                      buttonModel: ButtonModel(
                        onPressed: isLoading
                            ? null
                            : () => _pickAndPreview(context),
                        backgroundColor: AppColors.progressColor,
                        radius: 30.r,
                        customText: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isLoading)
                              SizedBox(
                                width: 20.w,
                                height: 20.h,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            else
                              Icon(
                                Icons.cloud_upload_rounded,
                                color: AppColors.white,
                                size: 20.sp,
                              ),
                            SizedBox(width: 10.w),
                            Flexible(
                              child: CustomText(
                                title: isLoading
                                    ? "processing".tr()
                                    : "uploadStatisticsFile".tr(),
                                textStyle: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 160.h,
                left: 0,
                right: 0,
                child: Center(
                  child: CustomText(
                    title: tile,
                    textStyle: Theme.of(
                      context,
                    ).textTheme.displayLarge!.copyWith(fontSize: 50.sp),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
